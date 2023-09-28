from unittest.mock import Mock, call, patch

from typer import Context

from boilerplate.cli import app


def test_app_commands():
    assert "hello-world" in [x.name for x in app.registered_commands]


@patch("boilerplate.cli.logger")
def test_app_callbacks(mock_log):
    ctx = Mock(spec=Context, invoked_subcommand="test-callback")
    app.registered_callback.callback(ctx)
    app.info.result_callback(ctx)
    assert mock_log.info.call_args_list == [
        call("Starting CLI command test-callback"),
        call("CLI command finished"),
    ]


@patch("builtins.print")
def test_hello_world(mock_print):
    cmd = next(x for x in app.registered_commands if x.name == "hello-world")
    cmd.callback()
    assert mock_print.call_args_list == [call("Hello World")]
