obs = obslua

local is_enabled = true
local time_until_clear = 1.50

function script_description()
    return "Restarts the replay buffer when saving a clip to prevent clip overlapping\n\n"..
    "Recommended timing based on own testing:\n\n"..
    "This script requires a delay of at least half a second between each toggle where nothing is recorded. "..
    "The values below may depend on your computers hardware- and or software.\n"..
    "Risky: 0.50s | Fast: 1.00s | Default: 1.50s"
end

function script_properties()
    local props = obs.obs_properties_create()

    obs.obs_properties_add_bool(props, "enable_script", "Enable script functionality")

    obs.obs_properties_add_float(props, "interval_seconds", "Seconds until clear", .5, 30, .25)

    obs.obs_properties_add_button(props, "restart_button", "Simulate Replay save", function()
        restart_replay_buffer()
    end)

    return props
end

function script_defaults(settings)
    obs.obs_data_set_default_bool(settings, "enable_script", true)
    obs.obs_data_set_default_double(settings, "interval_seconds", time_until_clear)
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
    time_until_clear = obs.obs_data_get_double(settings, "interval_seconds")
end

function restart_replay_buffer()
    if not is_enabled then
        return
    end

    if obs.obs_frontend_replay_buffer_active() then
        obs.script_log(obs.LOG_INFO, string.format("Restarting Replay Buffer (Duration: %.2f sec)", time_until_clear))
        obs.obs_frontend_replay_buffer_stop()
        obs.timer_add(function()
            obs.obs_frontend_replay_buffer_start()
            obs.script_log(obs.LOG_INFO, "Replay Buffer restarted successfully")
            obs.remove_current_callback()
        end, time_until_clear * 1000)
    else
        obs.script_log(obs.LOG_WARNING, "Replay Buffer has to be active for simulation")
    end
end