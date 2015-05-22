trigger AccountBefore on Account (before update) {
    
    System.debug('Account Before begin');
    
    for(Account acc : trigger.new)
        if(acc.OwnerId != trigger.OldMap.get(acc.Id).OwnerId && acc.Owner.UserType != trigger.OldMap.get(acc.Id).Owner.UserType ){
            System.debug('Owner Changed, New User Type ' + acc.Owner.UserType);
            
            AccountStaticUtil.opportunityOldOwnerMap.put(acc.Id, trigger.OldMap.get(acc.Id).OwnerId);
        }
   
    for(Opportunity opp : [Select Id, AccountId from Opportunity where AccountId In :AccountStaticUtil.opportunityOldOwnerMap.keySet()]){
        if(!AccountStaticUtil.accountOpportunityMap.keySet().contains(opp.AccountId))
            AccountStaticUtil.accountOpportunityMap.put(opp.AccountId, new List<Id>());
        AccountStaticUtil.accountOpportunityMap.get(opp.AccountId).add(opp.Id);
        AccountStaticUtil.opportunitiesRegistered.add(opp.Id);
    }
    
  
    System.debug('Account Before end');
}