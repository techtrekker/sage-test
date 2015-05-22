public class atMentionAutomation implements Process.plugin{
	
	public Process.PluginResult invoke(Process.PluginRequest request) {

		//Community ID if needed. Optional. ONLY USE IT IN THE PLUGIN IF YOU ARE ACTUALLY GOING TO USE IT
		String communityID = (String) request.inputParameters.get('communityID');
        //Record, group or object Id for the feed where you want to post the @mention.
        String subjectFeedId = (String) request.inputParameters.get('subjectFeedId');
        //What you want to say, the actual message for the chatter feed. 
        String chatterMsg = (String) request.inputParameters.get('chatterMsg');
        //List of ID's of folks you want to @mention, comma delmited, may have to convert ID to a string
        String atMentionList = (String) request.inputParameters.get('atMentionList');

        //This VWF Plugin uses ConnectAPI Helper class by 

        /**
 		*
 		* Helper class that makes it easier to post Chatter @-mentions with Apex code.
 		*
 		* See https://github.com/alouie-sfdc/ConnectApiHelper for more information.
 		*
 		*/


 		//Split out the comma delimited list of user ID's into a list.
 		List<String> atMentionIds = atMentionList.split('\\,');
 		
 		//String to use to format the @mentions like: {ID}{ID}
 		String atMentionString = '';


 		//Go through the list of Ids and format them like: {ID}{ID}
 		for (String atId : atMentionIds ){
			atMentionString = atMentionString + '{' + atId + '}';
		}

		//Update the Chatter message to add 2 empty lines and then the list of user IDs you want to @mention
		chatterMsg = chatterMsg + '\n\n' + atMentionString;

		//ConnectAPI Helper class to post the message. Remember the subjectID is the ID of the feed you want to post to. 
		ConnectApi.FeedItem fi = ConnectApiHelper.postFeedItemWithMentions(communityID, subjectFeedId, chatterMsg);


        //Return the result
        Map<String,Object> result = new Map<String,Object>();
        return new Process.PluginResult(result);

		
	}



	public Process.PluginDescribeResult describe() {
        Process.PluginDescribeResult result = new Process.PluginDescribeResult();


        //Title of the visual workflow plugin
        result.name='@Mention Chatter Message Automation';
        //Description of the plugin
        result.description='Automate @mentions in Chatter for Visual Workflow. Use this plugin to @mention folks when they need immediate notification in SF1 as well as the desktop. By Rob Calfee at Salesforce, rcalfee@salesforce.com';
        //Optional tag
        result.tag = 'Notifications';
        //Parameters that the plugin should capture and then send to the method above
        //Note, Community ID is optional
        //Communit ID: ONLY USE IT IN THE PLUGIN IF YOU ARE ACTUALLY GOING TO USE IT
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter> {
                        new Process.PluginDescribeResult.InputParameter(
                           'communityID','Community ID if posting to a specific community: OPTIONAL, do not select it unless you will be filling it out.',
                            Process.PluginDescribeResult.ParameterType.STRING,
                            false),
                        new Process.PluginDescribeResult.InputParameter(
                            'subjectFeedId', 'Group or record feed ID you want to post your @mention.',
                            Process.PluginDescribeResult.ParameterType.STRING,
                            true),
                        new Process.PluginDescribeResult.InputParameter(
                            'chatterMsg', 'The actual chatter message you want to post.',
                            Process.PluginDescribeResult.ParameterType.STRING,
                            true),
                        new Process.PluginDescribeResult.InputParameter(
                            'atMentionList', 'The list of user IDs you want to @mention, comma delimited as a string so may have to convert the ID to a string using string valueof.',
                            Process.PluginDescribeResult.ParameterType.STRING,
                            true)
                };


        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>{
                        new Process.PluginDescribeResult.OutputParameter('returnMsg',
                Process.PluginDescribeResult.ParameterType.STRING)
                    };
        return result;


    }
}