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
c.Spawner.notebook_dir = '/srv/jupyterhub/data'
c.JupyterHub.allow_named_servers = True
c.LocalAuthenticator.create_system_users = True

## 使用 gitlab 账户登录
# c.JupyterHub.authenticator_class = 'oauthenticator.gitlab.GitLabOAuthenticator'
# c.Authenticator.admin_users = {'admin'}

# 本地账户密码登录
c.JupyterHub.authenticator_class = 'jupyterhub.auth.DummyAuthenticator'
c.DummyAuthenticator.password = "123456"
c.Authenticator.allowed_users = ['root']
c.Authenticator.admin_users = {'root'}



