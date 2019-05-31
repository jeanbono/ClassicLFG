ClassicLFGDungeonGroup = {}
ClassicLFGDungeonGroup.__index = ClassicLFGDungeonGroup

setmetatable(ClassicLFGDungeonGroup, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function ClassicLFGDungeonGroup.new(dungeon, leader, title, description, source, members)
    local self = setmetatable({}, ClassicLFGDungeonGroup)
    self.Leader = leader or ClassicLFGPlayer()
    self.Members = members or ClassicLFGLinkedList()
    self.Description = description or ""
    self.Title = title or ""
    self.Dungeon = dungeon or ClassicLFG.Dungeon["The Deadmines"]
    self.Group = {
        Dps = 0,
        Tank = 0,
        Healer = 0
    }
    self.Source = source or { Type = "ADDON" }
    return self
end

function ClassicLFGDungeonGroup:AddMember(player)
    ClassicLFGLinkedList.AddItem(self.Members, player)
    ClassicLFG:DebugPrint("Added Group Member:" .. player.Name)
end

function ClassicLFGDungeonGroup:GetRoleCount(role)
    local count = 1
    for i = 0, self.Members.Size - 1 do
        if (ClassicLFGPlayer.GetSpecialization(ClassicLFGLinkedList.GetItem(self.Members, i)).Role.Name == role.Name) then
            count = count + 1
        end
    end
    
end

function ClassicLFGDungeonGroup:RemoveMember(player)
    self.Members:RemoveItemByComparison(player)
    ClassicLFG:DebugPrint("Removed Group Member: " .. player.Name)
end

function ClassicLFGDungeonGroup:Print()
    for key in pairs(self) do
        ClassicLFG:DebugPrint(key, self[key])
    end
end