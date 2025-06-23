@isTest
private class AegisMetricsBtchAssetsTest {
   @isTest
    static void testBatchExecution() {

        Test.startTest();
        Database.executeBatch(new AegisMetricsBtchAssets());
        Test.stopTest();

   
        List<Ativo_Tecnologico__c> ativosCriados = [
            SELECT Id, Name
            FROM Ativo_Tecnologico__c
            WHERE Name = 'AegisMetricsBtchAssets'
        ];

        System.assertEquals(1, ativosCriados.size(), 'O batch deveria ter criado um registro de ativo para a classe principal.');
    }
}