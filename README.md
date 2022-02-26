# KeyLibrary
Better Way To Create Key Binds / Key Handlers

###### Virgin Way of doing it 
```lua
game:GetService("UserInputService").InputEnded:Connect(function(Input, GameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode.A then
      print("a")
    elseif Input.KeyCode == Enum.KeyCode.B then
      print("b")
    elseif Input.KeyCode == Enum.KeyCode.C then
      print("b")
    end
end)
```
###### Chad Way of doing it 

```lua
local _, Key = loadstring(game:HttpGet('https://raw.githubusercontent.com/Perthys/KeyLibrary/main/main.lua'))()

local Test = Key({Enum.KeyCode.A, Enum.KeyCode.B, Enum.KeyCode.C}, function(self, Input)
    print(self.Key)
end) 

Test:Unbind()
```

# Doccumentation

```lua
local Key = loadstring(game:HttpGet('https://raw.githubusercontent.com/Perthys/KeyLibrary/main/main.lua'))()

local X = Key.new(Enum.KeyCode.X, "Test", function(self, Input)
    print(self.Key, self.Type)
end) -- Default Type is Tap

local Y = Key.new(Enum.KeyCode.Y, "Test", function(self, Input)
    print(self.Key, self.Type)
end, "Hold")

local Z = Key.new(Enum.KeyCode.Z, "Test", function(self, Input)
    print(self.Key, self.Type)
end, "Toggle")

-- Supports Different Syntax
local A =  Key.new(Enum.KeyCode.A, {
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type, self.Name)  -- Output: Enum.KeyCode.A Tap Test
    end,
})

local A =  Key.new(Enum.KeyCode.A, {
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type, self.Name)  -- Output: Enum.KeyCode.A Tap Test_1 (Auto Increments Naming To Prevent Name Overwriting)
    end,
})

local B =  Key.new(Enum.KeyCode.B, {
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type)  
    end,
    Type = "Hold" -- Default Type Is Tap
})

local Mouse1 =  Key.new(Enum.UserInputType.MouseButton1, { -- Supports UserInputTypes / Xbox Movement
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type)  
    end,
    Type = "Hold"
})

local Mouse2 = Key.new(Enum.UserInputType.MouseButton2, "Test", function(self, Input)
    print(self.Key, self.Type)
end)
```
