local mod = RegisterMod("AltAltRocks",1)
local rockrng = RNG()
function mod:SwapRocks()
    -- rock check
    local room = Game():GetRoom()
    local level = Game():GetLevel()
    if level:GetAbsoluteStage() == LevelStage.STAGE3_2 and level:GetStageType() < StageType.STAGETYPE_REPENTANCE then return end
    for i = 0, (room:GetGridSize()) do
        local gent = room:GetGridEntity(i) 
        if gent and gent:GetType() == GridEntityType.GRID_ROCK_ALT then
            local state = gent:GetSaveState()
            if state.VarData == 0 then
                if rockrng:RandomFloat() < 0.2 then
                    state.VarData = 2
                else
                    state.VarData = 1
                end
            end
            local sprite = gent:GetSprite()
            if state.VarData == 2 and state.State == 1 then
                sprite:SetAnimation("alt2")
                sprite:SetFrame(0)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.SwapRocks)