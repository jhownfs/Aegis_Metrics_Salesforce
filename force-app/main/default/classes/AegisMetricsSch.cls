public with sharing class AegisMetricsSch implements Schedulable {

    public void execute(SchedulableContext sc) {
         // This method is called by the Salesforce scheduler        
         AegisMetricsBatch batch = new AegisMetricsBatch();
         String jobId = System.scheduleBatch(batch, 'AegisMetricsBatch', 1, null);
    }
    
}