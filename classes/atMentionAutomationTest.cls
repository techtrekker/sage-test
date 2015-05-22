@IsTest(SeeAllData=true)
private class atMentionAutomationTest {
	
	static testmethod void atMentionAutomationTests() {
      
        atMentionAutomation plugin = new atMentionAutomation();
        Map<String,Object> inputParams = new Map<String,Object>();

        string subjectFeedIdvar = '0F9o0000000LMxi';
        InputParams.put('subjectFeedId', subjectFeedIdvar);
        string chatterMsgvar = 'Flow is alive';
        InputParams.put('chatterMsg', chatterMsgvar);
        string atMentionListvar = '005o0000000qdbd';
        InputParams.put('atMentionList', atMentionListvar);

        Process.PluginRequest request = new Process.PluginRequest(inputParams);           
        
        plugin.invoke(request);
    } 
	
}