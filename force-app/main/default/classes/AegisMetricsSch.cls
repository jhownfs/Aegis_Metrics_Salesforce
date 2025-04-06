public with sharing class AegisMetricsSch implements Schedulable {

    public void execute(SchedulableContext sc) {
         // This method is called by the Salesforce scheduler        
         ID jobID = System.enqueueJob(new AegisMetricsQueuebleMaster());
    }
}