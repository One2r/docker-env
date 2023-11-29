import os

from subprocess import check_call


def pre_spawn_hook(spawner):
    username = spawner.user.name
    try:
        check_call(['useradd', '-ms', '/bin/bash', username])
    except Exception as e:
        print(f'{e}')

c.Spawner.args = ['--allow-root']
c.Spawner.pre_spawn_hook = pre_spawn_hook
c.Spawner.notebook_dir = '~/jupyterhub'
c.JupyterHub.allow_named_servers = True
c.LocalAuthenticator.create_system_users = True

try:
    if(os.environ['JUPYTER_AUTHENTICATOR'] == "gitlab"): ## 使用 gitlab 账户登录
        c.JupyterHub.authenticator_class = 'oauthenticator.gitlab.GitLabOAuthenticator'
    else: # 本地账户密码登录
        c.JupyterHub.authenticator_class = 'jupyterhub.auth.DummyAuthenticator'
        c.DummyAuthenticator.password = os.environ['JUPYTER_DUMMY_PASSWORD']

    if (os.environ['JUPYTER_ADMIN_USERS']):
        c.Authenticator.admin_users = os.environ['JUPYTER_ADMIN_USERS'].split(",")

    if (os.environ['JUPYTER_ALLOWED_USERS']):
        c.Authenticator.allowed_users = c.Authenticator.admin_users = os.environ['JUPYTER_ALLOWED_USERS'].split(",")

except Exception as e:
    print(f'{e}')



