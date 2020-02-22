defmodule Spider.VerificationAgentToolKit do  
    use Agent

    def start_link(opts) do  
        Agent.start_link(fn -> opts end, [name: __MODULE__])
    end
    
    def put(pid, key, value) do
        Agent.update(pid, &Map.put(&1, key, value))
    end
    
    def get(pid, key) do  
        Agent.get(pid, &Map.get(&1, key))  
    end  

end 