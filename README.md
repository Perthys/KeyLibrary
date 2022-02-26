# KeyLibrary
Better Way To Create Key Binds / Key Handlers

```lua
-- Chad Way
local Key = loadstring(game:HttpGet('https://raw.githubusercontent.com/Perthys/KeyLibrary/main/main.lua'))()

local Test = Key.new({Enum.KeyCode.A, Enum.KeyCode.B, Enum.KeyCode.C}, function(self, Input)
    print(self.Key)
end) 

-- Virgin Way
game:GetService("UserInputService").InputEnded:Connect(function(Input, GameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode.A then
        print("a")
    elseif Input.KeyCode == Enum.KeyCode.B then
        print("b")
    elseif Input.KeyCode == Enum.KeyCode.C then
        print("b")
    end
end)

Test:Unbind()
```

## Key.new Variant 1
| Name                   | Type                                          | Description                                                                                                                                                                          |
|------------------------|-----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Key(s) **{required}**  | EnumItem (UserInputType, KeyCode) / Table                              | This Argument is used for registering KeyBinds you may pass a table or a single enum item                                                                                            |
| Name **{optional}**    | String **{Default: Auto-Increment Integer}**  | This Argument is used to denominate the Key Bind,  Using a name multiple times will auto-increment it.  If you do not pass any value it will give a auto incrementing integer value. |
| Handler **{required}** | Function                                      | This Function is called when the KeyBind is activated.                                                                                                                               |
| Type **{optional**     | String **{Default: Tap}**                     | This Argument is used for determining the KeyBind type, there are 3 types  {Tap, Toggle, Hold}                                                                  

**Example:**

```lua
local Example1 = Key.new(Enum.KeyCode.X, function(self, Input)
    print(self.Key, self.Type)
end) -- No KeyBind Type

local Example2 = Key.new(Enum.KeyCode.Y, "Test", function(self, Input)
    print(self.Key, self.Type)
end, "Hold") -- With Name

local Example3 = Key.new({Enum.KeyCode.Z, Enum.KeyCode.X}, function(self, Input)
    print(self.Key, self.Type)
end, "Tap") -- Without Name and Multiple KeyBind Syntax

local Example4 = Key.new({Enum.KeyCode.Z, Enum.KeyCode.X}, "Test", function(self, Input)
    print(self.Key, self.Type)
end, "Toggle") 

local Example5 = Key.new(Enum.UserInputType.MouseButton2, "Test", function(self, Input)
    print(self.Key, self.Type)
end) -- Different Input Type

local Example6 = Key.new(Enum.UserInputType.MouseButton1, function(self, Input)
    print(self.Key, self.Type)
end) -- Different Input Type Without Name

-- Remove KeyBinds

Example1:Unbind() 
Example2:Unbind() 
Example3:Unbind()
Example4:Unbind()
Example5:Unbind()
Example6:Unbind()
```

## Key.new Variant 2

| Name                                                                                                 | Type             | Description                                                                               |
|------------------------------------------------------------------------------------------------------|------------------|-------------------------------------------------------------------------------------------|
| Key(s) **{required}**                                                                                | EnumItem / Table | This Argument is used for registering KeyBinds you may pass a table or a single enum item |
| Data **{required}**<br>=> Name **{optional}** <br>=> Handler **{required}** <br>=> Type **{optional}** | Table            | This Table is used for Passing Data with a different syntax.                              |                          |


**Example:**

```lua
-- Supports Different Syntax
local A =  Key.new(Enum.KeyCode.A, {
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type, self.Name) 
    end,
})

local A2 =  Key.new(Enum.KeyCode.A, {
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type, self.Name)  
    end,
})

local B =  Key.new(Enum.KeyCode.B, {
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type)  
    end,
    Type = "Hold" 
})

local Mouse1 =  Key.new(Enum.UserInputType.MouseButton1, { 
    Name = "Test";
    Handler = function(self, Input)
        print(self.Key, self.Type)  
    end,
    Type = "Hold"
})
-- Remove KeyBinds
A:Unbind()
A2:Unbind()
B:Unbind()
Mouse1:Unbind()
```
## Key.AsyncNew 

Exact Same Syntax As Previously but it returns a promise

**Example**

```lua
Key.AsyncNew({Enum.KeyCode.A, Enum.KeyCode.B, Enum.KeyCode.C}, function(self, Input) print(self.Key) end, "Hold"):andThen(function(Obj)
    Obj:Unbind():andThen(function()
        
    end)
end)
```
