({
    
    //This retrieves the contract_clause_Assignment and the contract records from Apex
	doInit : function(component, event, helper) {          
        //This action is to populate the contract detail records
        var action = component.get("c.getContract"); 
        action.setCallback(this, function(data){
            component.set('v.contractAtt',data.getReturnValue());
        });
        
        //This action is to populate the Contract Clauses List
        var action2 = component.get("c.getContractClause"); 
        action2.setCallback(this, function(data){
        component.set('v.contractClauses',data.getReturnValue());
        });
       
        //Enqueue both actions    
        $A.enqueueAction(action);
        $A.enqueueAction(action2);
        
        //Set data table columns for Contract Clauses List
        var cols = [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Description', fieldName: 'Description__c', type: 'Long Text Area'},
            {label: 'Type', fieldName: 'Type__c', type: 'Picklist'}
        ];
        component.set("v.tableCols", cols);
        
        //Set data table columns for Contract Clause Assignments list
        var cols2 = [
              {label: 'Name', fieldName: 'Name', type: 'text'},
              {label: 'Type', fieldName: 'Contract__c', type: 'Master-Detail'},
              {label: 'Contract', fieldName: 'Contract_Clause__c', type: 'Master-Detail'}
        ];
        component.set("v.tableCols2", cols2);
	},
    
    //This method handle the detail panel
    panelOne : function(component, event, helper){
       	//Get components for the details panel
        var tab1 = component.find('tab-scoped-1');
        var tabOne = component.find('panelListOne');
        var tab2 = component.find('tab-scoped-2');
        var tabTwo = component.find('panelListTwo');
        //Add and remove show classes
        $A.util.removeClass(tab1, 'slds-tabs__content slds-hide');
        $A.util.addClass(tab1, 'slds-tabs__content slds-show');
        $A.util.addClass(tabOne, 'slds-is-active');
         
        $A.util.addClass( tab2, 'slds-tabs__content slds-hide');
        $A.util.removeClass( tab2,'slds-tabs__content slds-show');
        $A.util.removeClass( tabTwo, 'slds-is-active');
    },
    //This method handles the related panel
     panelTwo : function(component, event, helper){
         //Get components for the related list panel
        var tab1 = component.find('tab-scoped-1');
        var tabOne = component.find('panelListOne');
        var tab2 = component.find('tab-scoped-2');
        var tabTwo = component.find('panelListTwo');
         //Add and remove show classes to the related list panel
        $A.util.removeClass( tab2, 'slds-tabs__content slds-hide');
        $A.util.addClass( tab2, 'slds-tabs__content slds-show');
        $A.util.addClass( tabTwo, 'slds-is-active');
         
        $A.util.addClass(tab1, 'slds-tabs__content slds-hide');
        $A.util.removeClass(tab1,  'slds-tabs__content slds-show');
        $A.util.removeClass(tabOne, 'slds-is-active');
    },
    
    //Handle New Button Function
    handleNewButton : function(component, event, helper){
    var ContractClauseListDiv = component.find('contractClauseListDiv');
    //Show the Contract Clauses related List    
    $A.util.removeClass(ContractClauseListDiv, 'slds-tabs__content slds-hide');
    $A.util.addClass(ContractClauseListDiv, 'slds-tabs__content slds-show');
    },
    
    //Handle the Remove function
    handleRemoveButton : function(component, event, helper){
        //Action to delete selected assignments from list
        var action = component.get("c.deleteAssignments"); 
        action.setParams({
        'assignmentsToDelete':component.get("v.contractClauseAssignments")
         });
    $A.enqueueAction(action);
    window.location.reload();  
    },
    
    //Handles the Add Button Function
    //This function adds the selected records to the database
    handleAddButton : function(component, event, helper){
    var getSelectedRows = component.find('contractClasusesTable').getSelectedRows(); 
    var contractClauseAssinmentsListDiv = component.find('contractClauseAssinmentsListDiv');
    var action = component.get("c.linkContractToClause"); 
    action.setParams({
    'contract':component.get("v.contractAtt"),
    'clauses':getSelectedRows
     });  
        action.setCallback(this, function(data){
        component.set('v.contractClauseAssignments',data.getReturnValue());
        });
        
    $A.enqueueAction(action);
        
    $A.util.removeClass(contractClauseAssinmentsListDiv, 'slds-tabs__content slds-hide');
    $A.util.addClass(contractClauseAssinmentsListDiv, 'slds-tabs__content slds-show');
    }
    
  
})