trigger UserBefore on User(before insert){

    for(User usr : trigger.new)
        usr.UserPreferencesDisableAllFeedsEmail = true;

}