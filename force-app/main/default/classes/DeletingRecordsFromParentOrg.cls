public class DeletingRecordsFromParentOrg 
{
	public static void deleteAccount(List<Account> newAccList)
    {
        System.debug(newAccList);
        List<String> newIdList = new List<String>();
        
        for(Account acc : newAccList)
        {
            newIdList.add(acc.ParentId__c);
        }
        
        List<Account> oldAccList = [SELECT Id, ParentId__c FROM Account WHERE ParentId__c IN :newIdList];
        
        System.debug(oldAccList);
        
        if(!oldAccList.isEmpty())
        {
        	DELETE oldAccList;
        }
    }

}