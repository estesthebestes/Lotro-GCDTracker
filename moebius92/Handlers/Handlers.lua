import "Turbine";

-- Add an event handler to a Turbine object's event table.
-- Returns the handler function so the caller can remove it later.
AddEventHandler = function(object, event, f)
    if object[event] == nil then
        object[event] = {};
    end
    table.insert(object[event], f);
    return f;
end

-- Remove a previously-added event handler by reference.
RemoveEventHandler = function(object, event, handle)
    if object[event] ~= nil then
        for i = 1, #object[event] do
            if object[event][i] == handle then
                table.remove(object[event], i);
                break;
            end
        end
    end
end
