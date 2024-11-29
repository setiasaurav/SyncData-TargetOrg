public class UpdatingRecordsFromParentOrg 
{
	public static void updateAccount(List<Account> newAccList)
    {
        List<String> newIdList = new List<String>();
        
        for(Account acc : newAccList)
        {
            newIdList.add(acc.ParentId__c);
        }
        
        List<Account> oldAccList = [SELECT ParentId__c FROM Account WHERE ParentId__c IN :newIdList];
        
        List<Account> accToBeUpdated = new List<Account>();

        for(Account newAcc : newAccList)
        {
            for(Account oldAcc : oldAccList)
            {
                if(oldAcc.ParentId__c == newAcc.ParentId__c)
                {
                    Id ogId = oldAcc.Id;
                    oldAcc = newAcc;
                    oldAcc.Id = ogId;
                    accToBeUpdated.add(oldAcc);
                }
            }
        }
        UPDATE accToBeUpdated;
    }
    
    public static void updateOpportunity(List<Opportunity> newOppList)
    {
        List<String> newIdList = new List<String>();
        
        for(Opportunity opp : newOppList)
        {
            newIdList.add(opp.ParentId__c);
        }
        
        List<Opportunity> oldOppList = [SELECT ParentId__c FROM Opportunity WHERE ParentId__c IN :newIdList];
        
        List<Opportunity> oppToBeUpdated = new List<Opportunity>();

        for(Opportunity newOpp : newOppList)
        {
            for(Opportunity oldOpp : oldOppList)
            {
                if(oldOpp.ParentId__c == newOpp.ParentId__c)
                {
                    Id ogId = oldOpp.Id;
                    oldOpp = newOpp;
                    oldOpp.Id = ogId;
                    oppToBeUpdated.add(oldOpp);
                }
            }
        }
        UPDATE oppToBeUpdated;
    }
    
}