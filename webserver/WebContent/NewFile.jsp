<html>
  <head>
    <title>SigmaJS example</title>
    <script src="resources/js/sigma.min.js"></script>
    <script src="resources/js/plugins/sigma.plugins.relativeSize.min.js"></script>
    <style>
      html { height:100%;}
      body {height: 100%;}
      #sigma-container { width:100%; height:100%; background-color:#E1E1E1}
    </style>
  </head>
  <body>
    <div id='sigma-container'></div>
    <script>
    var nbNode = 50;
    var nbEdge = 100;
    var graph = {
      nodes: [],
      edges: []
    };
    for (i = 0; i < nbNode; i++)
      graph.nodes.push({ 
        id:  i,
        label: 'Node ' + i,
        x: Math.random(),
        y: Math.random(),
        size: 1,
        color: '#EE651D'
      });

    for (i = 0; i < nbEdge; i++)
      graph.edges.push({ 
        id: i, 
        label: 'Edge ' +i,
        source: '' + (Math.random() * nbNode | 0), 
        target: '' + (Math.random() * nbNode | 0),
        color: '#00000',
        type: 'curvedArrow',
      });


 // load the graph
    s.graph.read(graph);
    // call the plugin
    sigma.plugins.relativeSize(s, 1);
    // draw the graph
    s.refresh();
    // launch force-atlas for 5sec
    s.startForceAtlas2();
    window.setTimeout(function() {s.killForceAtlas2()}, 10000);
    </script>
  </body>
</html>