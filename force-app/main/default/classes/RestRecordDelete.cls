@RestResource(urlMapping= '/RecordDelete/*' )
global with sharing class RestRecordDelete
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
                List<Account> accList = new List<Account>();
                List<Opportunity> oppList = new List<Opportunity>();
                List<Contact> conList = new List<Contact>();
                List<Lead> leadList = new List<Lead>();
                
                for (sObject obj : deserializedRecords)
                {
                    obj.Id = null;
                    obj.put('OwnerId', UserInfo.getUserId());                    
                    String objectType = obj.getSObjectType().getDescribe().getName();
                    switch on objectType 
                    {
                        when 'Account' 
                        {
                            accList.add((Account) obj);
                        }
                        when 'Opportunity'
                        {
                            oppList.add((Opportunity) obj);
                        }
                        when 'Contact'
                        {
                            conList.add((Contact) obj);
                        }
                        when 'Lead'
                        {
                            leadList.add((Lead) obj);
                        }
                        when else 
                        {
                            return 'Cannot delete the ' + objectType + ' records.';
                        }
                    }
                    
                    if(!accList.isEmpty())
                    {
                        System.debug('RestRecordDelete' + accList);
                        DeletingRecordsFromParentOrg.deleteAccount(accList);
                    }
                    if(!oppList.isEmpty())
                    {
                       // DeletingRecordsFromParentOrg.deleteOpportunity(oppList);
                    }
                }
            }
            catch(Exception e)
            {
                System.debug('Delete Failed! ' +  e.getMessage());
            }
            System.debug('Records Deleted Succesfully from Parent Org --- ' + deserializedRecords);
            return 'Record Processed Successfully' ;
        }
        return 'Failure!';        
    }
}