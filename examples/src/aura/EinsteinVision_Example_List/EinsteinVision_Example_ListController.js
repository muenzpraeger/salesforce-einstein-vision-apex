({
    doInit : function(component, event, helper) {
        helper.showSpinner(component);
        var action = component.get("c.readDemoExamples");
        action.setCallback(this, function(response) {
            component.set("v.examples", response.getReturnValue());
            helper.hideSpinner(component);
        });
        $A.enqueueAction(action);
    }
})