# KeyLibrary
Better Way To Create Key Binds / Key Handlers

###### Chad Way of doing it 

```lua
local Key = loadstring(game:HttpGet('https://raw.githubusercontent.com/Perthys/KeyLibrary/main/main.lua'))()

local Test = Key.new({Enum.KeyCode.A, Enum.KeyCode.B, Enum.KeyCode.C}, function(self, Input)
    print(self.Key)
end) 

Test:Unbind()
```

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


