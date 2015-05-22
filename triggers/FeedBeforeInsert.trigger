trigger FeedBeforeInsert on FeedItem (before insert) {

    Pattern MyPattern = Pattern.compile('([(0-9)(aA-zZ)]){20}');
    
    for (FeedItem fItem : trigger.new){
        if(fItem.body != null){
        Matcher myMatcher = MyPattern.matcher(fItem.body);
        if(myMatcher.matches())
            fItem.body = fItem.body + ' replaced';
       }
    }
}