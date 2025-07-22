/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class SLATest {

    @isTest
    public static void TestCaseRouting() {
        // TO DO: implement unit test
        List<Case> CasesToInsert = new List<Case>();
        Case a = new Case(Status = 'New',Type = 'Technical',Priority = 'High',Origin = 'Web');
        Case f = new Case(Status = 'New',Type = 'Billing',Priority = 'Low',Origin = 'Web');
        Case g = new Case(Status = 'New',Type = 'General',Priority = 'Medium',Origin = 'Web');

        CasesToInsert.add(a);CasesToInsert.add(f); CasesToInsert.add(g);

        Test.startTest();
        insert CasesToInsert;
        Test.stopTest();

        List<Case> caseInserted = [Select Id,OwnerId,Type,Priority,Status From Case where Status = 'New' ];
        system.Assert.areEqual(3, caseInserted.size());
    }
}