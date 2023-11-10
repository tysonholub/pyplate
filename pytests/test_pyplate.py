from unittest.mock import call, patch

import pyplate


@patch("builtins.print")
def test_main(mock_print):
    pyplate.hello_world()
    assert mock_print.call_args_list == [call("Hello World")]
