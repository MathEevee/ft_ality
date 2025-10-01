let check_Arg argv =

	let argc = Array.length argv in
	if argc = 1 then
		begin
			print_endline "Usage : ./ft_ality <grammar_file>";
			false
		end
	else if argc > 2 then
		begin
			print_endline "Error : Too many arguments";
			false
		end
	else
		true

let init_Window width height =
	match Tsdl.Sdl.init Tsdl.Sdl.Init.video with
	| Error (`Msg e) -> print_endline ("Erreur SDL :" ^ e); 
		exit 1
	| Ok () -> ();

	match Tsdl.Sdl.create_window
		~w:width
		~h:height
		"Keyboard Window"
		Tsdl.Sdl.Window.shown
	with
	| Error (`Msg e) -> print_endline ("Erreur SDL :" ^ e);
		exit 1
	| Ok win -> win

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

let () =
	
	let argv = Sys.argv in
	if not (check_Arg argv) then 
		exit 1;

	(*let window = init_Window 400 200 in
	
	let rec loop () =
		match get_Key () with
		| Some key ->
			if key <> 0 then
				print_endline ("Key : " ^ string_of_int key);
			loop ()
		| None ->
			()
	in
		loop ();

	Tsdl.Sdl.destroy_window window;
  	Tsdl.Sdl.quit ()*)

	let (automate, alphabet) = Automate.create_Automate argv.(1) in
	List.iter print_endline alphabet;
	List.iter print_endline automate.values;
	let next_a = Trie.next_state automate " a" in
    List.iter print_endline next_a.values;
	print_endline "";
    let end_b = Trie.next_state next_a " b" in
    List.iter print_endline end_b.values;
	print_endline "";
	let end_a = Trie.next_state end_b " a" in
    List.iter print_endline end_a.values;
	print_endline "";
