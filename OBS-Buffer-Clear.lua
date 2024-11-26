obs = obslua

local is_enabled = true

function script_description()
    return "Restarts the replay buffer when saving a clip to prevent clip overlapping\n\n"..
    "Take into consideration, that this script requires a delay of one second between each toggle where nothing is recorded."
end

function script_properties()
    local props = obs.obs_properties_create()

    obs.obs_properties_add_bool(props, "enable_script", "Enable script functionality")

    obs.obs_properties_add_button(props, "restart_button", "Simulate Replay save", function()
        restart_replay_buffer()
    end)

    return props
end

function script_defaults(settings)
    obs.obs_data_set_default_bool(settings, "enable_script", true)
end

function script_load(settings)
    obs.obs_frontend_add_event_callback(function(event)
        if event == obs.OBS_FRONTEND_EVENT_REPLAY_BUFFER_SAVED then
            restart_replay_buffer()
        end
    end)
end

function script_update(settings)
    is_enabled = obs.obs_data_get_bool(settings, "enable_script")
end

function restart_replay_buffer()
    if not is_enabled then
        return
    end

    if obs.obs_frontend_replay_buffer_active() then
        obs.script_log(obs.LOG_INFO, "Restarting Replay Buffer...")
        obs.obs_frontend_replay_buffer_stop()
        obs.timer_add(function()
            obs.obs_frontend_replay_buffer_start()
            obs.script_log(obs.LOG_INFO, "Replay Buffer restarted successfully.")
            obs.remove_current_callback()
        end, 1000)
    else
        obs.script_log(obs.LOG_WARNING, "Replay Buffer is not active. Make sure it is for the script to work.")
    end
end