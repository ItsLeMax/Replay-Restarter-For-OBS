obs = obslua

local is_enabled = true
local time_until_clear = 1.50

function script_description()
    return
    "<style>"..
        "th { color:#4655d5; }"..
        "p { color:#ededed }"..
    "</style>"..

    "<h3>OBS Buffer Clear</h3>"..
    "<p>Restarts the replay buffer when saving a clip to prevent clip overlapping</p>"..

    "<h3>Recommended timing based on own testing</h3>"..
    "<p>OBS requires a delay of at least half a second between each toggle where nothing is recorded.</p>"..

    "<p><i>The values below may depend on your computers hardware- and or software.</i></p>"..

    "<p>If your computer is or will be stressed out or your hardware is not good enough, then you should "..
    "consider higher timings like the default one. Feel free to choose smaller ones otherwise. "..
    "It is recommended to test this in your use case to be sure.</p>"..

    "<p></p>"..

    "<table>"..
        "<tr>"..
            "<th>| Default</th>"..
            "<th>| Fast</th>"..
            "<th>| Risky</th>"..
        "</tr>"..
        "<tr>"..
            "<td>| 1.50s</td>"..
            "<td>| 1.00s</td>"..
            "<td>| 0.50s</td>"..
        "</tr>"..
    "</table>"
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