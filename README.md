# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File / Folder | Purpose
---------|----------
`app/` | content for UI frontends go here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps...

- Open a new terminal and run  `cds watch`
- ( in VSCode simply choose _**Terminal** > Run Task > cds watch_ )
- Start adding content, e.g. a [db/schema.cds](db/schema.cds), ...


## Learn more...

Learn more at https://cap.cloud.sap/docs/get-started/

## Authentication and Authorisation

### For Local development
* Add @requires and @restrict conditions in cat-service.js
* Add uaa details in package.json under requires of cds
``` js
"uaa": {
        "kind": "xsuaa"
      }
```
* Add auth details in .cdsrc.json
* Create xs-security.json file
``` bash
cds compile srv/ --to xsuaa > xs-security.json
```

### For Cloud deployment 
* Add mta file and add the path to xs-security.json in mta.yaml under the parameters of uaa resource
``` bash
cds add mta
```
path: ./xs-security.json
* Deploy to cloud foundry using mta
<ol>
  <li>
    <p>Download and install the <a href="https://github.com/cloudfoundry-incubator/multiapps-cli-plugin/blob/master/README.md" target="_blank">MTA plugin for the CF CLI</a>.</p>
    cf install-plugin multiapps
  </li>
  <li>Install the <a href="https://sap.github.io/cloud-mta-build-tool/" target="_blank">MTA Build Tool</a>:
    <div class="language-sh highlighter-rouge"><div class="highlight"><pre class="highlight"><a class="copy" title="Copy to Clipboard"></a><code>  npm <span class="nb">install</span> <span class="nt">-g</span> mbt
</code></pre></div>    </div>
    <blockquote>
      <p>You might need to install more things (for example, GNU Make on Windows), to let the MBT run. Consider the installation section of the <a href="https://sap.github.io/cloud-mta-build-tool/" target="_blank">MTA Build Tool guide</a>.</p>
    </blockquote>
  </li>
  <li>To have the MTA development descriptor <code class="language-plaintext highlighter-rouge">mta.yaml</code> created in the project root folder, execute
    <div class="language-sh highlighter-rouge"><div class="highlight"><pre class="highlight"><a class="copy" title="Copy to Clipboard"></a><code>  cds add mta
</code></pre></div>    </div>
    <blockquote>
      <p>For deployment to trial landscapes, replace the service type <code class="language-plaintext highlighter-rouge">hana</code> by <code class="language-plaintext highlighter-rouge">hanatrial</code> for the <code class="language-plaintext highlighter-rouge">com.sap.xs.hdi-container</code> resource in <code class="language-plaintext highlighter-rouge">mta.yaml</code>.</p>
    </blockquote>
  </li>
  <li>Run the MTA Build Tool through:
    <div class="language-sh highlighter-rouge"><div class="highlight"><pre class="highlight"><a class="copy" title="Copy to Clipboard"></a><code>  mbt build <span class="nt">-t</span> ./
</code></pre></div>    </div>
    <p>An archive with extension <code class="language-plaintext highlighter-rouge">.mtar</code> is created in project root.</p>
  </li>
  <li>Log in to your Cloud Foundry space.</li>
  <li>Deploy to Cloud Foundry with:
    <div class="language-sh highlighter-rouge"><div class="highlight"><pre class="highlight"><a class="copy" title="Copy to Clipboard"></a><code>  cf deploy &lt;.mtar file&gt;  <span class="c"># for example, bookshop_1.0.0.mtar</span>
</code></pre></div>    </div>
    <p>This can take some minutes.</p>
  </li>
  <li>Identify the URL of the application, for example <code class="language-plaintext highlighter-rouge">bookshop-srv</code>, in the CF space. Either watch the <code class="language-plaintext highlighter-rouge">cf deploy</code> log output, or use the SAP Cloud Platform Cockpit. Open this URL in your browser.</li>
</ol>