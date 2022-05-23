import express from 'express';
import bodyParser from 'body-parser';

const app = express();

app.use(bodyParser.json());


const articlesInfo = {
    'learn react': {
        upvotes: 0,
        comments: [],
    },
    'learn-node': {
        upvotes: 0,
        comments: [],
    },
    'my-thoughts-on-resumes': {
        upvotes: 0,
        comments: [],
    }
}




app.post('/api/articles/:name/upvote', (req, res) => {
    const articleName = req.params.name;
    articlesInfo[articleName].upvotes += 1;
    res.status(200).send(`${articlename} now has ${articlesInfo[articleName].upvotes} upvotes`);
})
app.post('/api/articles/:name/add-comment', (req, res) => {
    const { username, text } = req.body;
    const articleName = req.params.name;
    articlesInfo[articleName].comments.push({ username, text });
    res.status(200).send(`${username} added a comment`);
});

app.listen(8000, () => console.log('listening on port 8000'));