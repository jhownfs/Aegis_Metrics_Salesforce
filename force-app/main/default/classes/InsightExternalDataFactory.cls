public with sharing class InsightExternalDataFactory {
  
    public static InsightsExternalData createInsightExternalData(String EdgemartAlias) {

        InsightsExternalData  insightExternalData = new InsightsExternalData();
        
        insightExternalData.EdgemartAlias = EdgemartAlias;
        insightExternalData.Format = 'Csv';
        insightExternalData.Operation = 'Overwrite';
        
        return insightExternalData;
    }
}