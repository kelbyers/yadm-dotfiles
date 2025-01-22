# this file is both a valid
# - overlay which can be loaded with `overlay use starship.nu`
# - module which can be used with `use starship.nu`
# - script which can be used with `source starship.nu`
export-env {
    let starship_prompt = (which starship | get 0.path)

    $env.STARSHIP_SHELL = "nu";

    load-env {
        STARSHIP_SESSION_KEY: (random chars -l 16)
        PROMPT_MULTILINE_INDICATOR: (
            ^$starship_prompt prompt --continuation
        )

        # Does not play well with default character module.
        # TODO: Also Use starship vi mode indicators?
        PROMPT_INDICATOR: ""

        PROMPT_COMMAND: {||
            # jobs are not supported
            (
                ^$starship_prompt prompt
                    --cmd-duration $env.CMD_DURATION_MS
                    $"--status=($env.LAST_EXIT_CODE)"
                    --terminal-width (term size).columns
            )
        }


        config: ($env.config? | default {} | merge {
            render_right_prompt_on_last_line: true
        })

        # PROMPT_COMMAND_RIGHT: {||
        #     (
        #         date now | format date '%m/%d/%Y %r'
        #         # ^'C:\Users\kel\scoop\shims\starship.exe' prompt
        #         #     --right
        #         #     --cmd-duration $env.CMD_DURATION_MS
        #         #     $"--status=($env.LAST_EXIT_CODE)"
        #         #     --terminal-width (term size).columns
        #     )
        # }
    }

    # set NU_OVERLAYS with overlay list, useful for starship prompt
    $env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | append {||
        let overlays = overlay list | range 1..
        if not ($overlays | is-empty) {
            $env.NU_OVERLAYS = $overlays | str join ", "
        } else {
            $env.NU_OVERLAYS = null
        }
    })

}
