@RestResource(urlMapping= '/RecordInsert/*' )
global with sharing class RestRecordInsert 
{
    @HttpPost
    global static String receiveRecords() 
    {
        String jsonRecords = RestContext.request.requestBody.tostring();
        
        List<sObject> deserializedRecords = (List<sObject>) JSON.deserialize(jsonRecords, List<sObject>.class);
        
        if(!deserializedRecords.isEmpty())
        {
            try
            {
                for (sObject obj : deserializedRecords)
                {
					obj.Id = null;
                    obj.put('OwnerId', UserInfo.getUserId());
                }
                Insert deserializedRecords;
            }
            catch(Exception e)
            {
                System.debug('Insertion Failed! ' +  e.getMessage());
            }
            System.debug('Records Inserted Succesfully from Parent Org --- ' + deserializedRecords);
            return 'Record Processed Successfully' ;
        }
        return 'Failure!';        
    }
}