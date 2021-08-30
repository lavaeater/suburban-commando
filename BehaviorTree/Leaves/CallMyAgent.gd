extends Leaf

class_name CallMyAgent

export (String) var MethodToCall = ""

func run():
	.run()
	if tree.agent_path and MethodToCall != "":
		var agent = tree.get_node(tree.agent_path)
		var result = agent.call(MethodToCall)
		if result == Task.SUCCEEDED:
			success()
		elif result == Task.FAILED:
			fail()
		elif result == Task.RUNNING:
			running()
		elif result == Task.CANCELLED:
			cancel()
			
