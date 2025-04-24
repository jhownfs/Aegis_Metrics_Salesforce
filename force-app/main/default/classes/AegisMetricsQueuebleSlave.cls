public with sharing class AegisMetricsQueuebleSlave implements Queueable {

    private Eventlogfile currentEventLogFile;
    private List<Eventlogfile> eventLogFiles;

    public AegisMetricsQueuebleSlave( Eventlogfile eventLogFile, List<Eventlogfile> eventLogFiles) {
        // Constructor logic can be added here if needed
        this.currentEventLogFile = eventLogFile;
        this.eventLogFiles = eventLogFiles;
    }

    public void execute(QueueableContext context) {
       
        try { 
              
              // Add the event log file to the map
              List<String> fieldNames = this.currentEventLogFile.LogFileFieldNames.split(',');
              List<String> fieldTypes = this.currentEventLogFile.LogFileFieldTypes.split(',');

              map<String,String> eventLogFileJson = new map<String,String>();

              for(Integer i = 0; i < fieldNames.size(); i++) {

                eventLogFileJson.put(fieldNames[i], fieldTypes[i]);

              }

              AegisMetricsSchemaGenerator schemaGenerator = new AegisMetricsSchemaGenerator(eventLogFileJson, this.currentEventLogFile.EventType);

              Blob schemaBlob = Blob.valueOf(schemaGenerator.generetaSchemaEventlog());

              InsightsExternalData insightExternalData = AegisMetricsInsightExternalDataFactory.createInsightExternalData(this.currentEventLogFile.EventType, schemaBlob);
              
              Database.insert(insightExternalData);

              Blob fileContent = this.currentEventLogFile.LogFile;

              InsightsExternalDataPart insightExternalDataPart = AegisMetricsInsightExternalDataPtFactory.createInsightExternalDataPart(fileContent, insightExternalData.Id, 1);
           
              Database.insert(insightExternalDataPart);

              insightExternalData.Action = 'Process';
                
              Database.update(insightExternalData);

              if(hasCurrentQueueableStackDepthReached()) {
                  return;
              }

              processNextEventLogFile();
            
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        } 
    }


    private void processNextEventLogFile() {
        eventLogFile nextEventLogfile = getNextEventLogFileToProcess();

        if (nextEventLogfile != null) {
            AegisMetricsQueuebleSlave queueableJob = new AegisMetricsQueuebleSlave(nextEventLogfile, this.eventLogFiles);
            System.enqueueJob(queueableJob);
        }
    }

    private eventLogFile getNextEventLogFileToProcess() {
    
        Integer indexCurrentElement = this.eventLogFiles.indexOf(this.currentEventLogFile);

        this.eventLogFiles.remove(indexCurrentElement);

        if (isLastEventLogFile()) {
            return null;
        }

        eventLogFile nextEventLogfile = this.eventLogFiles.get(0);

        return nextEventLogfile;
    }

    private boolean isLastEventLogFile() {
        return this.eventLogFiles.isEmpty();
    }

    private boolean hasCurrentQueueableStackDepthReached() {
       return (System.AsyncInfo.getCurrentQueueableStackDepth() >= 50);
    }
    
}