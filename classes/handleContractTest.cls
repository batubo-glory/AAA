@isTest
public class handleContractTest {
    public static testMethod void getcontractClauseTest(){
        Contract_Clauses__c testContractClauses = new Contract_Clauses__c();
        testContractClauses.Name = 'Test Name';
        testContractClauses.Description__c = 'Test Description';
        testContractClauses.Type__c = 'Flexible Length';
        insert testContractClauses;
        
        test.startTest();
        List<Contract_Clauses__c> testClausesList = handleContract.getContractClause();
        test.stopTest();
        System.assert(testClausesList != null);
        System.AssertEquals(testClausesList == null, False);
    }
    
    public static testMethod void getContractTest(){
        //create account record
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        
        Contract  contractTest = new Contract();
        contractTest.AccountId = acc.Id; 
        insert contractTest;
        
        test.startTest();
        Contract con = handleContract.getContract();
        test.stopTest();
        System.assert(con != null);
        System.AssertEquals(con == null, False);
    }
    
    public static testMethod void deleteAssignmentsTest(){
        Account accTwo = new Account();
        accTwo.Name = 'Test Account Two';
        insert accTwo;  
        
        Contract  contractTestTwo = new Contract();
        contractTestTwo.AccountId = accTwo.Id; 
        insert contractTestTwo;
        
        Contract_Clauses__c testContractClausesTwo = new Contract_Clauses__c();
        testContractClausesTwo.Name = 'Test Two Name';
        testContractClausesTwo.Description__c = 'Test Two Description';
        testContractClausesTwo.Type__c = 'Flexible Length';
        insert testContractClausesTwo;
        
        Contract_Clauses__c testContractClausesThree = new Contract_Clauses__c();
        testContractClausesThree.Name = 'Test Three Name';
        testContractClausesThree.Description__c = 'Test Three Description';
        testContractClausesThree.Type__c = 'Flexible Length';
        insert testContractClausesThree;
        
        List<Contract_to_Clause_Assignment__c> assignmentList = new List<Contract_to_Clause_Assignment__c>();
        List<ID> assignmentID = new List<ID>();
        
        Contract_to_Clause_Assignment__c assignmentTest = new Contract_to_Clause_Assignment__c();
        assignmentTest.Contract__c = contractTestTwo.id;
        assignmentTest.Contract_Clause__c = testContractClausesTwo.id;
        assignmentList.add(assignmentTest);
        
        
        Contract_to_Clause_Assignment__c assignmentTestTwo = new Contract_to_Clause_Assignment__c();
        assignmentTestTwo.Contract__c = contractTestTwo.id;
        assignmentTestTwo.Contract_Clause__c = testContractClausesThree.id;
        assignmentList.add(assignmentTestTwo);
        insert assignmentList;
        
        for(Contract_to_Clause_Assignment__c assignIds : assignmentList){
            assignmentID.add(assignIds.id);
        }
               
        test.startTest();			
                List<Contract_to_Clause_Assignment__c> recordsToDelete =  [select ID from
                Contract_to_Clause_Assignment__c Where ID IN :assignmentID];       
                handleContract.deleteAssignments(assignmentList);  
                List<Contract_to_Clause_Assignment__c> afterDelete = [select ID from
                Contract_to_Clause_Assignment__c Where ID IN :assignmentID]; 
                System.assert(afterDelete.size() == 0);
                System.AssertEquals(afterDelete.size() == 2, False);
        test.stopTest();   	
           
    }
    
    
      public static testMethod void deleteAssignmentsTestTwo(){
        Account accTwo = new Account();
        accTwo.Name = 'Test Account Two';
        insert accTwo;  
        
        Contract  contractTestTwo = new Contract();
        contractTestTwo.AccountId = accTwo.Id; 
        insert contractTestTwo;
        
        Contract_Clauses__c testContractClausesTwo = new Contract_Clauses__c();
        testContractClausesTwo.Name = 'Test Two Name';
        testContractClausesTwo.Description__c = 'Test Two Description';
        testContractClausesTwo.Type__c = 'Flexible Length';
        insert testContractClausesTwo;
        
        Contract_Clauses__c testContractClausesThree = new Contract_Clauses__c();
        testContractClausesThree.Name = 'Test Three Name';
        testContractClausesThree.Description__c = 'Test Three Description';
        testContractClausesThree.Type__c = 'Flexible Length';
        insert testContractClausesThree;
        
        List<Contract_to_Clause_Assignment__c> assignmentList = new List<Contract_to_Clause_Assignment__c>();
        List<Contract_to_Clause_Assignment__c> assignmentListSingle = new List<Contract_to_Clause_Assignment__c>();
        List<ID> assignmentID = new List<ID>();
        List<ID> assignmentIDSingle = new List<ID>();
        
        Contract_to_Clause_Assignment__c assignmentTest = new Contract_to_Clause_Assignment__c();
        assignmentTest.Contract__c = contractTestTwo.id;
        assignmentTest.Contract_Clause__c = testContractClausesTwo.id;
        assignmentList.add(assignmentTest);
        
        
        Contract_to_Clause_Assignment__c assignmentTestTwo = new Contract_to_Clause_Assignment__c();
        assignmentTestTwo.Contract__c = contractTestTwo.id;
        assignmentTestTwo.Contract_Clause__c = testContractClausesThree.id;
        assignmentList.add(assignmentTestTwo);
        insert assignmentList;
        
        for(Contract_to_Clause_Assignment__c assignIds : assignmentList){
            assignmentID.add(assignIds.id);
        }
        
        assignmentIDSingle.add(assignmentTestTwo.ID);
		assignmentListSingle.add(assignmentTestTwo);          
        
        
        test.startTest();
                Contract_to_Clause_Assignment__c recordsToDelete =  [select ID from
                Contract_to_Clause_Assignment__c Where ID IN :assignmentIDSingle];      
                handleContract.deleteAssignments(assignmentListSingle); 
          		List<Contract_to_Clause_Assignment__c> afterDelete = [select ID from
                Contract_to_Clause_Assignment__c Where ID IN :assignmentIDSingle]; 
                System.assert(afterDelete.size() == 0);
                System.AssertEquals(afterDelete.size() == 2, False);
       test.stopTest();        
    }
    
        public static testMethod void linkContractToClauseTest(){
        //create account record
        
        List<Contract_to_Clause_Assignment__c> assignmentList = new List<Contract_to_Clause_Assignment__c>();
        List<ID> clauseIds = new List<ID>();
        List<Contract_Clauses__c> clausesList = new List<Contract_Clauses__c>();

            
		Account acc = new Account();
        acc.Name = 'Test Account Two';
        insert acc;  
        
        Contract  contractTest = new Contract();
        contractTest.AccountId = acc.Id; 
        insert contractTest;
            
        Contract_Clauses__c testContractClauses = new Contract_Clauses__c();
        testContractClauses.Name = 'Test Name';
        testContractClauses.Description__c = 'Test Description';
        testContractClauses.Type__c = 'Flexible Length';
        clausesList.add(testContractClauses);
            
        Contract_Clauses__c testContractClausesTwo = new Contract_Clauses__c();
        testContractClausesTwo.Name = 'Test Two Name';
        testContractClausesTwo.Description__c = 'Test Two Description';
        testContractClausesTwo.Type__c = 'Flexible Length';
        clausesList.add(testContractClausesTwo);
        insert clausesList;
            
        test.startTest();     
        List<Contract_to_Clause_Assignment__c> assigns = handleContract.linkContractToClause(clausesList, contractTest); 
        System.assert(assigns.size() == 2);
        System.AssertEquals(assigns.size() == 0, False);
        test.stopTest();
    }
}