local function try(t, c, f)
    local co = cocreate(t)
    local s, m = true
    while s and costatus(co) ~= "dead" do
      s, m = coresume(co)
      if not s then
      c(m)
      end
    end
    if f then
      f()
    end
  end
  
  local test_result = 0
  function test(name, test)
    cursor_y = peek(0x5f27)
    
    print("⧗",4,cursor_y,12)
    print(name,13,cursor_y,6)
  
    try(function()
        test()
        print("⧗",4,cursor_y,0)
        print("➡️",4,cursor_y,11)
      end,
      function()
        test_result = 1
        print("⧗",4,cursor_y,0)
        print("❎",4,cursor_y,8)
      end
    )
  
    print("")
  end
  
  function check_tests()
    if test_result == 0 then
      return
    end
    stop("tests failed")
  end
