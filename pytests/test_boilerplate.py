from unittest.mock import call, patch

import boilerplate


@patch("builtins.print")
def test_main(mock_print):
    boilerplate.hello_world()
    assert mock_print.call_args_list == [call("Hello World")]
