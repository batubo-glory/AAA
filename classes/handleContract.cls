public class handleContract {
     //This method retrieves the Contract_Clauses records
       @AuraEnabled
    public static List<Contract_Clauses__c> getContractClause(){
        return [SELECT Name, Description__c, Type__c FROM Contract_Clauses__c];       
    }
    
    
    //Method to handle the contact details page
    @Auraenabled
    public static Contract getContract(){
        Contract conts = [select ID, Owner.Name ,Status, ContractNumber, StartDate, Account.Name, EndDate, CustomerSigned.Name, ContractTerm, CustomerSignedTitle, OwnerExpirationNotice, CustomerSignedDate, CompanySigned.Name, Pricebook2Id, CompanySignedDate, BillingAddress, ActivatedDate, ActivatedBy.Name, LastModifiedBy.Name, CreatedBy.Name, SpecialTerms, Description from Contract];
        return conts;
    }
  	
    //This method handles the deletion of records
         @AuraEnabled
    public static void deleteAssignments(List<Contract_to_Clause_Assignment__c> assignmentsToDelete){
        
        //List to store IDs from parameter
        List<ID> assignmentIds = new List<ID>();
        
        //For loop to extract Ids from parameter
        for(Contract_to_Clause_Assignment__c assignIds :  assignmentsToDelete){
            assignmentIds.add(assignIds.ID);
        }
        
        //If statement to check if ID is a list or a single record
        //After check it deletes the records
        if(assignmentIds.size() == 1){
                Contract_to_Clause_Assignment__c recordsToDelete =  [select ID from
                Contract_to_Clause_Assignment__c Where ID IN :assignmentIds];      
                delete recordsToDelete;   
        }				
        else if(assignmentIds.size() > 1){
                List<Contract_to_Clause_Assignment__c> recordsToDelete =  [select ID from
                Contract_to_Clause_Assignment__c Where ID IN :assignmentIds];       
                delete recordsToDelete;   
        }             
    }


    //This method links the Contract_Clauses and the Contracts and creates the Contract_Clause_Assignment junction object
       @AuraEnabled
    public static List<Contract_to_Clause_Assignment__c>linkContractToClause(List <Contract_Clauses__c> clauses, Contract contract){
        //List to store Contract Clause Assignments
        List<Contract_to_Clause_Assignment__c> contractToClauseList = new List<Contract_to_Clause_Assignment__c>();
        //List of Contract Clause IDs
        List<ID> clauseIds = new List<ID>();
        
        //Creates the contract clause assignment record
        for(Contract_Clauses__c clausesParam : clauses){
        Contract_to_Clause_Assignment__c contractToClauseAssignment =  new Contract_to_Clause_Assignment__c(
                                Name =clausesParam.name + ' ' + contract.ContractNumber, 
                                Contract_Clause__c = clausesParam.id,
                               	Contract__c = contract.ID
                               );
                               contractToClauseList.add(contractToClauseAssignment);
        }       
        insert(contractToClauseList);
        
        //Loop tro populate the Contract Clause Id list
        for(Contract_to_Clause_Assignment__c conToClauseAssigns : contractToClauseList){
            clauseIds.add(conToClauseAssigns.id);
        }
        
        // return statement returns the contract clause Assignment records
     return [select ID, Name, Contract__c, Contract_Clause__c from
                Contract_to_Clause_Assignment__c where ID IN :clauseIds];       
    }      
}