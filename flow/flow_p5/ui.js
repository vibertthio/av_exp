zebra.ready(function() {
   // import all classes, functions, constants
   // from zebra.ui, zebra.layout packages
   eval(zebra.Import("ui", "layout"));

   // create canvas
   var root = (new zCanvas(400, 400)).root;
   root.properties({
       layout : new BorderLayout(8,8),
       border : new Border(),
       padding: 8,
       kids: {
          //  CENTER: new TextField("Hi ...\n", true),
           CENTER: new Slider(),
           BOTTOM: new Button("Clear").properties({
               canHaveFocus: false
           })
       }
   });

   root.find("//zebra.ui.Button").bind(function() {
       root.find("//zebra.ui.TextField").setValue("");
   });
});
