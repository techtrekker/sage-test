trigger AccountAfter on Account (after update) {
    
    System.debug('Begin Account After');
    
    for(Opportunity opp : [Select Id, OwnerId, AccountId from Opportunity where AccountId IN :trigger.new AND IsClosed=false]){
        
            System.debug(opp.Id + ' , Opp Owner Id ' + opp.OwnerId + ' , Account Owner ' + trigger.newMap.get(opp.AccountId).OwnerId);
    }
    
    System.debug('End Account After');
}