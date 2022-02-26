local shared = shared or _G -- to be extra extra extra safe

local UserInputService = game:GetService("UserInputService");

local Key = {} Key.__index = Key;

shared.KeyStorage = {}; -- fuck using Key real chads make a new unessacarry table
shared.NameCount = {} -- Just incase sharing table

local TypeHandlers = {
	["Toggle"] = function(self, Input)
        self.LoopState = not self.LoopState
        
        while self.LoopState do
            self.Handler(self, Input)
            task.wait()
        end
	end,
	["Hold"] = function(self, Input)
	    print("Test")
    
            self.LoopState = true;
        	
	task.spawn(function()
            while self.LoopState  do
                self.Handler(self, Input)
                task.wait()
       	    end
	end)
	end,
	["Tap"] = function(self, Input)
        self.Handler(self, Input);
	end,
}

local EndedInputHandlers = {
	["Hold"] = function(self, Input)
	    self.LoopState  = false;  
	end,
	["Ended"] = function(self, Input)
	    self.Handler(self, Input)
	end,
}

function Key.new(...)
    if typeof(select(1, ...)) == "EnumItem" then
        if type(select(2, ...)) ==  "string" then 
            local Args = {...}
            
            local _Key = Args[1]
            local Name = Args[2];  if not shared.KeyStorage[_Key] then shared.KeyStorage[_Key] = {}; end
            local Handler = Args[3] 
            local Type = Args[4] or "Tap"
    
    	    if shared.KeyStorage[_Key][Name] then
    	        if not shared.NameCount[Name] then shared.NameCount[Name] = 0 end
    	        
    	        shared.NameCount[Name] = shared.NameCount[Name] + 1 -- Some Parsers don't support +=
    		    Name = ("%s_%s"):format(Name, shared.NameCount[Name])
    	    end
    
    	    local self = {
    		    Key = _Key,
    		    Name = Name,
    		    Handler = Handler,
    		    Type = Type,
    		    LoopState = false;
    	    }
    
    	    local Meta = setmetatable(self, {__index = Key, __call = Handler});
    
    	    shared.KeyStorage[_Key][Name] = Meta;
    
    	    return Meta;
        elseif type(select(2, ...)) ==  "table" then 
            local Args = {...}
            
            local _Key = Args[1]; if not shared.KeyStorage[_Key] then shared.KeyStorage[_Key] = {}; end
            
            local Name = Args[2]["Name"] or #shared.KeyStorage[_Key] + 1
            local Handler = Args[2]["Handler"]
            local Type = nil;
            
            if Args[2]["Type"] then
                Type = Args[2]["Type"] 
            else
                Type = "Tap" 
            end
    
    	    if shared.KeyStorage[_Key][Name] then
    	        if not shared.NameCount[Name] then shared.NameCount[Name] = 0 end
    	        
    	        shared.NameCount[Name] = shared.NameCount[Name] + 1 -- Some Parsers don't support +=
    		    Name = ("%s_%s"):format(Name, shared.NameCount[Name])
    	    end
    
    	    local self = {
    		    Key = _Key,
    		    Name = Name,
    		    Handler = Handler,
    		    Type = Type,
    		    LoopState = false;
    	    }
    
    	    local Meta = setmetatable(self, {__index = Key, __call = Handler});
    
    	    shared.KeyStorage[_Key][Name] = Meta;
    
    	    return Meta;
    	    
    	elseif type(select(2, ...)) ==  "function" then 
            local Args = {...}
            
            local _Key = Args[1];  if not shared.KeyStorage[_Key] then shared.KeyStorage[_Key] = {}; end
            local Name = #shared.KeyStorage[_Key] + 1
            local Handler = Args[2] 
            local Type = Args[3] or "Tap"
    
    	    if shared.KeyStorage[_Key][Name] then
    	        if not shared.NameCount[Name] then shared.NameCount[Name] = 0 end
    	        
    	        shared.NameCount[Name] = shared.NameCount[Name] + 1 -- Some Parsers don't support +=
    		    Name = ("%s_%s"):format(Name, shared.NameCount[Name])
    	    end
    
    	    local self = {
    		    Key = _Key,
    		    Name = Name,
    		    Handler = Handler,
    		    Type = Type,
    		    LoopState = false;
    	    }
    
    	    local Meta = setmetatable(self, {__index = Key, __call = Handler});
    
    	    shared.KeyStorage[_Key][Name] = Meta;
    
    	    return Meta;
    	end
    elseif type(select(1, ...)) == "table" then
        if type(select(2, ...)) == "string" then
            local Args = {...}
            
            local Keys = Args[1]
            local Name = Args[2];  
            local Handler = Args[3] 
            local Type = Args[4] or "Tap"
            
            local MultiArray = {}
                
            for Index, _Key in pairs(Keys) do
                MultiArray[#MultiArray + 1] = Key.new(_Key, Name, Handler, Type);
            end
    
    	    local self = {
    		    Name = Name,
    		    Handler = Handler,
    		    Type = Type,
    		    LoopState = false;
    		    MultiArray = MultiArray
    	    }
    
    	    local Meta = setmetatable(self, {__index = Key, __call = Handler});
    
    	    return Meta;
        elseif type(select(2, ...)) == "table" then
            local Args = {...}
            
            local Keys = Args[1]
            local Data = Args[2]
            local Handler = Data["Handler"]
            
            local MultiArray = {}
            
            for Index, _Key in pairs(Keys) do
                if Data["Name"] then
                    MultiArray[#MultiArray + 1] = Key.new(_Key, Name, Handler, Type);
                else
                    MultiArray[#MultiArray + 1] = Key.new(_Key, Handler, Type);
                end
            end
            
            local self = {
    		    Name = Name,
    		    Handler = Handler,
    		    Type = Type,
    		    LoopState = false;
    		    MultiArray = MultiArray
    	    }
    
    	    local Meta = setmetatable(self, {__index = Key, __call = Handler});
    
    	    return Meta;
            
        elseif type(select(2, ...)) == "function" then
            local Args = {...}
            
            local Keys = Args[1]
            local Handler = Args[2]
            
            local MultiArray = {}
            
            for Index, _Key in pairs(Keys) do
                MultiArray[#MultiArray + 1] = Key.new(_Key, Handler, Type);
            end
            
            local self = {
    		    Name = Name,
    		    Handler = Handler,
    		    Type = Type,
    		    LoopState = false;
    		    MultiArray = MultiArray
    	    }
    
    	    local Meta = setmetatable(self, {__index = Key, __call = Handler});
    
    	    return Meta;
        end
	end
end

function Key.Unbind(self)
    if self.MultiArray then
        for Index, Obj in pairs(self.MultiArray) do
            Obj:Unbind()
        end
    else
	    shared.KeyStorage[self.Key][self.Name] = nil;
	end
end

if shared.InputBegan and shared.InputEnded then
    shared.InputBegan:Disconnect()
    shared.InputEnded:Disconnect()
end

shared.InputBegan = 
UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
	if not GameProcessedEvent then
		if Input.UserInputType == Enum.UserInputType.Keyboard and shared.KeyStorage[Input.KeyCode] then
			for _, self in pairs(shared.KeyStorage[Input.KeyCode]) do
				if TypeHandlers[self.Type]  then
				    TypeHandlers[self.Type](self, Input)
				end
			end
		elseif shared.KeyStorage[Input.UserInputType] then
			for _, self in pairs(shared.KeyStorage[Input.UserInputType]) do
	            if TypeHandlers[self.Type] then
				    TypeHandlers[self.Type](self, Input)
				end
			end
		end
	end
end)

shared.InputEnded = 
UserInputService.InputEnded:Connect(function(Input, GameProcessedEvent)
	if not GameProcessedEvent then
		if Input.UserInputType == Enum.UserInputType.Keyboard and shared.KeyStorage[Input.KeyCode] then
			for _, self in pairs(shared.KeyStorage[Input.KeyCode]) do
				if EndedInputHandlers[self.Type] then
				    EndedInputHandlers[self.Type](self, Input)
				end
			end
		elseif shared.KeyStorage[Input.UserInputType] then
			for _, self in pairs(shared.KeyStorage[Input.UserInputType]) do
	            if EndedInputHandlers[self.Type] then
				    EndedInputHandlers[self.Type](self, Input)
				end
			end
		end
	end
end)

return Key, Key.new;
