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
    if type(select(2, ...)) ==  "string" then 
        local Args = {...}
        
        local Key = Args[1]
        local Name = Args[2];  if not shared.KeyStorage[Key] then shared.KeyStorage[Key] = {}; end
        local Handler = Args[3] 
        local Type = Args[4]

	    local Type = Type or "Tap";

	    if shared.KeyStorage[Key][Name] then
	        if not shared.NameCount[Name] then shared.NameCount[Name] = 0 end
	        
	        shared.NameCount[Name] = shared.NameCount[Name] + 1 -- Some Parsers don't support +=
		    Name = ("%s_%s"):format(Name, shared.NameCount[Name])
	    end

	    local self = {
		    Key = Key,
		    Name = Name,
		    Handler = Handler,
		    Type = Type,
		    LoopState = false;
	    }

	    local Meta = setmetatable(self, {__index = Key, __call = Handler});

	    shared.KeyStorage[Key][Name] = Meta;

	    return Meta;
    elseif type(select(2, ...)) ==  "table" then 
        local Args = {...}
        
        local Key = Args[1]; if not shared.KeyStorage[Key] then shared.KeyStorage[Key] = {}; end
        
        local Name = Args[2]["Name"]
        local Handler = Args[2]["Handler"]
        local Type = nil;
        
        if Args[2]["Type"] then
            Type = Args[2]["Type"] 
        else
            Type = "Tap" 
        end

	    local Type = Type or "Tap";

	    if shared.KeyStorage[Key][Name] then
	        if not shared.NameCount[Name] then shared.NameCount[Name] = 0 end
	        
	        shared.NameCount[Name] = shared.NameCount[Name] + 1 -- Some Parsers don't support +=
		    Name = ("%s_%s"):format(Name, shared.NameCount[Name])
	    end

	    local self = {
		    Key = Key,
		    Name = Name,
		    Handler = Handler,
		    Type = Type,
		    LoopState = false;
	    }

	    local Meta = setmetatable(self, {__index = Key, __call = Handler});

	    shared.KeyStorage[Key][Name] = Meta;

	    return Meta;
	end
end

function Key:Unbind(self)
	shared.KeyStorage[self.Key][self.Name] = nil;
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

return Key, Key.new
