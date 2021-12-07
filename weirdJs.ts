//nested double spread opoerator of an object
slideOverContent.update((v) => {
  return {
    ...v,
    graphNode: forwardNodes[0].target,
    graph: { ...v.graph, cameraPosition },
  };
});

