({
    showSpinner : function (component) {
        var spinner = component.find('spinner');
        $A.util.toggleClass(spinner, "slds-hide");
    },
    hideSpinner : function (component) {
        var spinner = component.find('spinner');
        $A.util.toggleClass(spinner, "slds-hide"); 
    }
})