let get_Key () =
	let event = Tsdl.Sdl.Event.create () in
		if Tsdl.Sdl.poll_event (Some event) then
			begin
				let key_action = Tsdl.Sdl.Event.(get event Tsdl.Sdl.Event.typ) in
				if key_action = Tsdl.Sdl.Event.quit then
					None
				else if key_action = Tsdl.Sdl.Event.key_down then
					let key = Tsdl.Sdl.Event.(get event keyboard_keycode) in
						if key = Tsdl.Sdl.K.escape then
							None
						else
							Some key
				else
					Some 0
			end
		else
			begin
				Tsdl.Sdl.delay (Int32.of_int 50);
				Some 0
			end