public with sharing class InsightExternalDataFactory {
  
    public static InsightsExternalData createInsightExternalData(String EdgemartAlias) {

        InsightsExternalData  insightExternalData = new InsightsExternalData();
        
        insightExternalData.EdgemartAlias = EdgemartAlias;
        insightExternalData.Format = 'Csv';
        insightExternalData.Operation = 'Overwrite';
        insightExternalData.EdgemartContainer = 'AegisMetrics';
        
        return insightExternalData;
    }
}