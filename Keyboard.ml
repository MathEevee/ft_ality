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

let rec key_Loop () =
	match get_Key () with
	| None ->
		None
	| Some key ->
		if key <> 0 then
			Some key
		else
			key_Loop ()


let create_Key_Mapping alphabet =
	let key_mapping = [] in
	let rec fill_Key_Mapping rest_alphabet key_mapping =
		match rest_alphabet with
		| [] -> Some (List.rev key_mapping)
		| head :: tail ->
			print_endline ("Please enter a key to assign to : " ^ head);
			match key_Loop ()  with
			| None -> None
			| Some assigned_key -> 
				match List.assoc_opt assigned_key key_mapping with
				| Some sym ->
					Print.print_Warning ("This key is already assigned to : " ^ sym);
					fill_Key_Mapping rest_alphabet key_mapping
				| None ->
					Print.print_Assigned (head ^ " is now assigned to : " ^ (Tsdl.Sdl.get_key_name assigned_key));
					let key_mapping = (assigned_key, head) :: key_mapping in
					fill_Key_Mapping tail key_mapping
	in fill_Key_Mapping alphabet key_mapping
