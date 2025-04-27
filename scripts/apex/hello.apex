// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

/*list<Event_Monitoring_Type__mdt> eventMonitoringTypes = EventMonitoringTypesSelector.getEnabledToIngestEventMonitoring();
system.debug('eventMonitoringTypes: ' + eventMonitoringTypes);

list<String> eventMonitoringTypeLabels = new List<String>();

for( Event_Monitoring_Type__mdt eventMonitoringType : eventMonitoringTypes ) {
    eventMonitoringTypeLabels.add(eventMonitoringType.MasterLabel.deleteWhitespace());
}
system.debug('eventMonitoringTypeLabels: ' + eventMonitoringTypeLabels);

 // Get the event log files for the enabled event monitoring types
list<Eventlogfile> eventLogFiles = EventLogFileSelector.getEventLogFiles(eventMonitoringTypeLabels);*/

String jsonData = '{ "MasterLabel" : "UITelemetryNavigationTiming"';
jsonData += ', "Log_File_Field_Names__c": ';
jsonData+='"EVENT_TYPE,TIMESTAMP,REQUEST_ID,ORGANIZATION_ID,USER_ID,DEVICE_SESSION_ID,UI_EVENT_TIMESTAMP,UI_EVENT_RELATIVE_TIMESTAMP,UI_ROOT_ACTIVITY_ID,USER_TYPE,CLIENT_ID,SESSION_KEY,LOGIN_KEY,CLIENT_GEO,CONNECTION_TYPE,APP_NAME,SDK_APP_VERSION,DEVICE_PLATFORM,DEVICE_MODEL,SDK_VERSION,BROWSER_NAME,BROWSER_VERSION,OS_NAME,OS_VERSION,PAGE_URL,PAGE_ENTITY_TYPE,PAGE_CONTEXT,PAGE_ENTITY_ID,SDK_APP_TYPE,DURATION,URL,START_TIME,INITIATOR_TYPE,NEXT_HOP_PROTOCOL,RENDER_BLOCKING_STATUS,WORKER_START,REDIRECT_START,REDIRECT_END,FETCH_START,DOMAIN_LOOKUP_START,DOMAIN_LOOKUP_END,CONNECT_START,SECURE_CONNECTION_START,CONNECT_END,REQUEST_START,RESPONSE_START,FIRST_INTERIM_RESPONSE_START,RESPONSE_END,TRANSFER_SIZE,ENCODED_BODY_SIZE,DECODED_BODY_SIZE,RESPONSE_STATUS,SERVER_REQUEST_ID,UI_THREAD_RESPONSE_DELAY,DOM_COMPLETE,DOM_CONTENT_LOADED_EVENT_START,DOM_CONTENT_LOADED_EVENT_END,DOM_INTERACTIVE,LOAD_EVENT_START,LOAD_EVENT_END,REDIRECT_COUNT,NAVIGATION_TYPE,UNLOAD_EVENT_START,UNLOAD_EVENT_END,TIMESTAMP_DERIVED,USER_ID_DERIVED,CLIENT_IP"';
jsonData += ', "Log_File_Field_Types__c": ';
jsonData+='"String,String,String,Id,Id,String,Number,Number,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Number,String,Number,String,String,String,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,String,Number,Number,Number,Number,Number,Number,Number,Number,String,Number,Number,DateTime,Id,String"';
jsonData += '}'; 
AegisMetricsServices.uploadSampleData(jsonData);
   
/*map<String,String> eventLogFileMap = new map<String,String>();

for( Eventlogfile eventLogFile : eventLogFiles ) {
    // Add the event log file to the map
    List<String> fieldNames = eventLogFile.LogFileFieldNames.split(',');
    List<String> fieldTypes = eventLogFile.LogFileFieldTypes.split(',');

    for(Integer i = 0; i < fieldNames.size(); i++) {

      eventLogFileMap.put(fieldNames[i], fieldTypes[i]);

    }
    
}   

AegisSchemaGenerator schemaGenerator = new AegisSchemaGenerator(eventLogFileMap , 'DatabaseSave');

// Generate the schema for the event log file
String formatgenerated = schemaGenerator.generetaSchemaEventlog();

System.debug('eventLogFiles: ' + formatgenerated);

System.debug('schemaGenerator: ' + blob.valueOf(formatgenerated));*/

//System.enqueueJob(new AegisMetricsQueuebleSlave(eventLogFiles[0]));