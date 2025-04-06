public with sharing class AegistMetricsQueuebleSlave implements Queueable, Database.AllowsCallouts {

    private Eventlogfile eventLogFiles;

    public AegistMetricsQueuebleSlave( Eventlogfile eventLogFile ){
        // Constructor logic can be added here if needed
        this.eventLogFiles = eventLogFile;
    }

    public void execute(QueueableContext context) {

        
        
    }
}