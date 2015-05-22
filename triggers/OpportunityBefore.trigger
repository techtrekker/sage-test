trigger OpportunityBefore on Opportunity (before update) {
    
    System.debug('Opportunity Before begin');
    
    for(Opportunity opp : trigger.new)
        if(opp.OwnerId != trigger.OldMap.get(opp.Id).OwnerId)
            System.debug('Owner Changed');
            
    
    System.debug('Opportunity Before end');
}