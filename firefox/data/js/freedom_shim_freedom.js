// Part of FreeDOM shim that allows FreeDOM to talk to other scripts
// and allows scripts to listen to events from FreeDOM.

(function(freedom) {
  addon.port.on("freedom_shim", function(args) {
    freedom.emit(args.event, args.data);
  });

  // Another script wants to listen to events from FreeDOM, so we
  // start listening to freedom for that event.
  addon.port.on("freedom_shim_listen", function(event) {
    freedom.on(event, function(freedomOutput) {
      var args = {event: event,
		  data: freedomOutput,
		  id: "FreeDOM"};
      addon.port.emit("freedom_shim", args);
    });
  });
}(this.freedom));
