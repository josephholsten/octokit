module Octokit
  class Client
    module Repositories

      def search_repositories(q, options={})
        get("repos/search/#{q}", options)['repositories']
      end
      alias :search_repos :search_repositories

      def repository(repo, options={})
        get("repos/show/#{Repository.new(repo)}", options)['repository']
      end
      alias :repo :repository

      def update_repository(repo, values, options={})
        post("repos/show/#{Repository.new(repo)}", options.merge({:values => values}))['repository']
      end
      alias :update_repo :update_repository

      def repositories(username=login, options={})
        get(["repos/show", username].compact.join('/'), options)['repositories']
      end
      alias :list_repositories :repositories
      alias :list_repos :repositories
      alias :repos :repositories

      def watch(repo, options={})
        post("repos/watch/#{Repository.new(repo)}", options)['repository']
      end

      def unwatch(repo, options={})
        post("repos/unwatch/#{Repository.new(repo)}", options)['repository']
      end

      def fork(repo, options={})
        post("repos/fork/#{Repository.new(repo)}", options)['repository']
      end

      def create_repository(name, options={})
        post("repos/create", options.merge(:name => name))['repository']
      end
      alias :create_repo :create_repository
      alias :create :create_repository

      def delete_repository(repo, options={})
        response = post("repos/delete/#{Repository.new(repo)}", options)
        if response.respond_to?(:delete_token)
          response['delete_token']
        else
          response['repository']
        end
      end
      alias :delete_repo :delete_repository

      def delete_repository!(repo, options={})
        response = post("repos/delete/#{Repository.new(repo)}", options)
        post("repos/delete/#{Repository.new(repo)}", options.merge(:delete_token => response['delete_token']))['repository']
      end
      alias :delete_repo! :delete_repository!

      def set_private(repo, options={})
        post("repos/set/private/#{Repository.new(repo)}", options)['repository']
      end

      def set_public(repo, options={})
        post("repos/set/public/#{Repository.new(repo)}", options)['repository']
      end

      def deploy_keys(repo, options={})
        get("repos/keys/#{Repository.new(repo)}", options)['public_keys']
      end
      alias :list_deploy_keys :deploy_keys

      def add_deploy_key(repo, title, key, options={})
        post("repos/key/#{Repository.new(repo)}/add", options)['public_keys']
      end

      def remove_deploy_key(repo, id, options={})
        post("repos/key/#{Repository.new(repo)}/remove", options.merge(:id => id))['public_keys']
      end

      def collaborators(repo, options={})
        get("repos/show/#{Repository.new(repo)}/collaborators", options)['collaborators']
      end
      alias :collabs :collaborators

      def add_collaborator(repo, collaborator, options={})
        post("repos/collaborators/#{Repository.new(repo)}/add/#{collaborator}")['collaborators']
      end
      alias :add_collab :add_collaborator

      def remove_collaborator(repo, collaborator, options={})
        post("repos/collaborators/#{Repository.new(repo)}/remove/#{collaborator}")['collaborators']
      end
      alias :remove_collab :remove_collaborator

      def pushable(options={})
        get("repos/pushable", options)['repositories']
      end

      def repository_teams(repo, options={})
        get("repos/show/#{Repository.new(repo)}/teams", options)['teams']
      end
      alias :repo_teams :repository_teams
      alias :teams :repository_teams

      def contributors(repo, anon=false, options={})
        if anon
          get("repos/show/#{Repository.new(repo)}/contributors/anon", options)
        else
          get("repos/show/#{Repository.new(repo)}/contributors", options)
        end['contributors']
      end
      alias :contribs :contributors

      def watchers(repo, options={})
        get("repos/show/#{Repository.new(repo)}/watchers", options)['watchers']
      end

      def network(repo, options={})
        get("repos/show/#{Repository.new(repo)}/network", options)['network']
      end

      def languages(repo, options={})
        get("repos/show/#{Repository.new(repo)}/languages", options)['languages']
      end

      def tags(repo, options={})
        get("repos/show/#{Repository.new(repo)}/tags", options)['tags']
      end

      def branches(repo, options={})
        get("repos/show/#{Repository.new(repo)}/branches", options)['branches']
      end

    end
  end
end
