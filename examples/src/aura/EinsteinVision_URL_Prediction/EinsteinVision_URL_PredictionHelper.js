({
    predictUrl : function(component, event) {
        var url = component.find("fldUrl").get("v.value");
        if (url!="") {
	        var action = component.get("c.predictUrl");
            action.setParams({url : url});
            action.setCallback(this, function(response) {
                 component.set("v.predictionsUrl", response.getReturnValue());
                 console.log(response.getReturnValue());
			});
	        $A.enqueueAction(action);
        }
    }
})