public class UndeletingRecordsFromParentOrg 
{
	public static void undeleteAccount(List<Account> newAccList)
    {
        System.debug(newAccList);
        List<String> newIdList = new List<String>();
        
        for(Account acc : newAccList)
        {
            newIdList.add(acc.ParentId__c);
        }
        
        List<Account> oldAccList = [SELECT Id, ParentId__c 
                                    FROM Account 
                                    WHERE ParentId__c IN :newIdList 
                                    AND IsDeleted = TRUE 
                                    ALL ROWS];
        
        System.debug(oldAccList);
        
        if(!oldAccList.isEmpty())
        {
        	UNDELETE oldAccList;
        }
    }

}